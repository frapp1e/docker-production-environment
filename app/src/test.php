<?php
$mysqli = new mysqli(getenv('DB_HOST'), getenv('DB_USER'), getenv('DB_PASSWORD'), getenv('DB_NAME'));
if ($mysqli->connect_error) die("Error: " . $mysqli->connect_error);

$result = $mysqli->query("SELECT * FROM usuarios");
while ($row = $result->fetch_assoc()) {
    echo "ID: {$row['id']}, Nombre: {$row['nombre']}, Email: {$row['email']}<br>";
}
?>

