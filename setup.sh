#!/bin/bash

echo "Aplicando schema no banco de dados..."

# Aplicar SQL no banco existente
docker compose exec -T db mariadb -u test -ptest test < init.sql

if [ $? -eq 0 ]; then
    echo "Schema criado com sucesso!"
    echo ""
    echo "Testando a aplicação:"
    echo ""
    
    # Testar GET
    echo "1. GET /posts"
    curl -s http://localhost:3000/posts | head -20
    echo ""
    echo ""
    
    # Testar POST
    echo "2. POST /posts"
    curl -s -X POST http://localhost:3000/posts \
      -H "Content-Type: application/json" \
      -d '{"title":"Teste Docker","text":"Post criado via script"}'
    echo ""
    echo ""
    
    echo "Tudo funcionando!"
else
    echo "show databases"
    echo "Erro ao criar schema"
    exit 1
fi