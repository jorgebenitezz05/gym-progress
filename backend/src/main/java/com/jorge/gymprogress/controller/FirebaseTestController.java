package com.jorge.gymprogress.controller;

import com.google.cloud.firestore.Firestore;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class FirebaseTestController {

    private final Firestore firestore;

    public FirebaseTestController(Firestore firestore) {
        this.firestore = firestore;
    }

    // Endpoint para comprobar que Spring Boot conecta correctamente con Firebase
    @GetMapping("/api/firebase-test")
    public Map<String, Object> comprobarFirebase() throws Exception {
        Map<String, Object> datos = new HashMap<>();

        datos.put("mensaje", "Conexión con Firebase funcionando");
        datos.put("estado", "OK");

        firestore.collection("test")
                .document("conexion")
                .set(datos)
                .get();

        return datos;
    }
}