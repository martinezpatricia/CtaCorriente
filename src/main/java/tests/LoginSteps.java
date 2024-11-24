package tests;

import io.cucumber.java.After;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.By;
import org.openqa.selenium.chrome.ChromeDriver;
import io.cucumber.java.en.*;

public class LoginSteps {
    WebDriver driver = null;

    @Given("El usuario está en la página de login")
    public void el_usuario_esta_en_la_pagina_de_login() {
        // Configurar el WebDriver y abrir la página de login
        driver = new ChromeDriver();
        driver.get("http://laptop-jbs5nl7o:8081/CtaCorriente-1.0-SNAPSHOT/login.jsp");
    }

    @When("El usuario introduce un username y contraseña válidos")
    public void el_usuario_introduce_credenciales_validas() {
        // Localizar los elementos y enviar las credenciales
        WebElement inputUsername = driver.findElement(By.id("username"));
        WebElement inputPassword = driver.findElement(By.id("password"));
        inputUsername.sendKeys("juan2000");
        inputPassword.sendKeys("123456");
        driver.findElement(By.tagName("button")).click();
    }

    // Agrega métodos similares para los otros pasos
    // ...

    @After
    public void cleanUp(){
        driver.close();
    }
}
