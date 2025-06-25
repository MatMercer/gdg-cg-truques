#!/bin/bash

# Cleanup function to kill the donut process
cleanup() {
    if [ ! -z "$DONUT_PID" ]; then
        kill $DONUT_PID 2>/dev/null || true
    fi
    if [ ! -z "$SERVER_PID" ]; then
        kill $SERVER_PID 2>/dev/null || true
    fi
    exit
}

docker compose down cache-proxy

# Set up trap to catch Ctrl+C and other termination signals
trap cleanup SIGINT SIGTERM SIGQUIT

docker compose up -d

# Check if gcc is available
if command -v gcc >/dev/null 2>&1; then
    echo "GCC encontrado. Compilando e executando animação do donut..."
    gcc -Wno-implicit-function-declaration -Wno-string-plus-char -Wno-implicit-int -o donut donut.c
    
    clear
    ./donut & 
    DONUT_PID=$!
    echo "Pressione Enter para parar a animação e abrir a apresentação..."
    read
    kill $DONUT_PID
else
    echo "GCC não encontrado. Pulando animação do donut..."
    sleep 2
fi

pushd presentation
python3 -m http.server 8080 &
SERVER_PID=$!
popd

# Detect OS and use appropriate command to open presentation
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open 'http://localhost:8080'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    xdg-open 'http://localhost:8080'
else
    echo "Sistema operacional não suportado. Abra manualmente: presentation/index.html"
fi

echo "Pressione Enter para finalizar..."
read

cleanup

