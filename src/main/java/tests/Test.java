package tests;

public class Test {
     public static void main(String[] args) {
        LoginSteps loginSteps = new LoginSteps();
        loginSteps.el_usuario_esta_en_la_pagina_de_login();
        loginSteps.el_usuario_introduce_credenciales_validas();
    }
}

