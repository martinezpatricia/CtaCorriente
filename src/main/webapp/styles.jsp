<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .body-container {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        width: 300px;
        text-align: center;
    }

    .welcome-message {
        margin-bottom: 20px;
    }

    .navbar {
        background-color: #333;
        overflow: hidden;
        width: 100%;
        position: fixed;
        top: 0;
    }

    .navbar a {
        float: left;
        display: block;
        color: white;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
    }

    .navbar a:hover {
        background-color: #ddd;
        color: black;
    }

    button {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 4px;
        background-color: #5c6bc0;
        color: white;
        font-size: 16px;
        cursor: pointer;
    }

    button:hover {
        background-color: #3f51b5;
    }

    .form-group {
        margin-bottom: 15px;
    }

    label {
        display: block;
        margin-bottom: 5px;
    }

    input[type="text"],
    input[type="password"],
    input[type="email"],
    input[type="number"],
    input[type="tel"],
    select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }
    
    select:focus { /* Estilos adicionales para cuando el select está enfocado */
        outline: none;
        border-color: #5c6bc0;
    }




</style>
