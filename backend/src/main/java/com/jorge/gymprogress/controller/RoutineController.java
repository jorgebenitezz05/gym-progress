package com.jorge.gymprogress.controller;

import com.jorge.gymprogress.model.Routine;
import com.jorge.gymprogress.service.RoutineService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/routines")
public class RoutineController {

    private final RoutineService routineService;

    public RoutineController(RoutineService routineService) {
        this.routineService = routineService;
    }

    // Lista todas las rutinas
    @GetMapping
    public List<Routine> obtenerTodasLasRutinas() {
        return routineService.obtenerTodasLasRutinas();
    }

    // Obtiene una rutina concreta por su id
    @GetMapping("/{id}")
    public ResponseEntity<Routine> obtenerRutinaPorId(@PathVariable Long id) {
        return routineService.obtenerRutinaPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Crea una nueva rutina
    @PostMapping
    public ResponseEntity<Routine> crearRutina(@Valid @RequestBody Routine routine) {
        Routine nuevaRutina = routineService.crearRutina(routine);
        return ResponseEntity.ok(nuevaRutina);
    }

    // Actualiza una rutina existente
    @PutMapping("/{id}")
    public ResponseEntity<Routine> actualizarRutina(
            @PathVariable Long id,
            @Valid @RequestBody Routine rutinaActualizada
    ) {
        return routineService.actualizarRutina(id, rutinaActualizada)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Elimina una rutina por su id
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarRutina(@PathVariable Long id) {
        boolean eliminada = routineService.eliminarRutina(id);

        if (!eliminada) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.noContent().build();
    }
}