<?php
function loadEnv() {
    // Use absolute path to the .env file
    $filePath = __DIR__ . '/.env';

    if (!file_exists($filePath)) {
        throw new Exception("The .env file was not found at the path: " . $filePath);
    }

    // Read .env file line by line
    $lines = file($filePath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

    foreach ($lines as $line) {
        // Skip comments and empty lines
        if (strpos(trim($line), '#') === 0 || trim($line) === '') {
            continue;
        }

        // Split the line into key and value
        list($key, $value) = explode('=', $line, 2);

        // Clean up key and value
        $key = trim($key);
        $value = trim($value, " \t\n\r\0\x0B'\"");

        // Store in $_ENV global variable
        $_ENV[$key] = $value;
    }
}
