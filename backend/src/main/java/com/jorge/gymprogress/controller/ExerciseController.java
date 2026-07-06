package com.jorge.gymprogress.controller;

import com.jorge.gymprogress.model.Exercise;
import com.jorge.gymprogress.service.ExerciseService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/exercises")
public class ExerciseController {

    private final ExerciseService exerciseService;

    public ExerciseController(ExerciseService exerciseService) {
        this.exerciseService = exerciseService;
    }

    // Lista todos los ejercicios
    @GetMapping
    public List<Exercise> obtenerTodosLosEjercicios() {
        return exerciseService.obtenerTodosLosEjercicios();
    }

    // Obtiene un ejercicio concreto por su id
    @GetMapping("/{id}")
    public ResponseEntity<Exercise> obtenerEjercicioPorId(@PathVariable Long id) {
        return exerciseService.obtenerEjercicioPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Crea un nuevo ejercicio
    @PostMapping
    public ResponseEntity<Exercise> crearEjercicio(@Valid @RequestBody Exercise exercise) {
        Exercise nuevoEjercicio = exerciseService.crearEjercicio(exercise);
        return ResponseEntity.ok(nuevoEjercicio);
    }

    // Actualiza un ejercicio existente
    @PutMapping("/{id}")
    public ResponseEntity<Exercise> actualizarEjercicio(
            @PathVariable Long id,
            @Valid @RequestBody Exercise exerciseActualizado
    ) {
        return exerciseService.actualizarEjercicio(id, exerciseActualizado)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Elimina un ejercicio por su id
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarEjercicio(@PathVariable Long id) {
        boolean eliminado = exerciseService.eliminarEjercicio(id);

        if (!eliminado) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.noContent().build();
    }
}