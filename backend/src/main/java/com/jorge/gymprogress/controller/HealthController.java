package com.jorge.gymprogress.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
public class HealthController {

    // Endpoint para comprobar que el backend está funcionando correctamente
    @GetMapping("/api/health")
    public Map<String, Object> comprobarEstado() {
        Map<String, Object> respuesta = new HashMap<>();

        respuesta.put("estado", "OK");
        respuesta.put("mensaje", "GymProgress backend funcionando correctamente");
        respuesta.put("fechaHora", LocalDateTime.now());

        return respuesta;
    }
}