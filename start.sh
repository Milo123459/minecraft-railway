if [ "$LAZYMC" = "TRUE" ]; then
    lazymc start
else
    java -jar /app/server.jar
fi