error id: file:///C:/Users/jorge/OneDrive/Documentos/Proyecto%20GYM/gym-progress/backend/src/main/java/com/jorge/gymprogress/controller/RoutineExerciseController.java:_empty_/PathVariable#
file:///C:/Users/jorge/OneDrive/Documentos/Proyecto%20GYM/gym-progress/backend/src/main/java/com/jorge/gymprogress/controller/RoutineExerciseController.java
empty definition using pc, found symbol in pc: _empty_/PathVariable#
empty definition using semanticdb
empty definition using fallback
non-local guesses:

offset: 2202
uri: file:///C:/Users/jorge/OneDrive/Documentos/Proyecto%20GYM/gym-progress/backend/src/main/java/com/jorge/gymprogress/controller/RoutineExerciseController.java
text:
```scala
package com.jorge.gymprogress.controller;

import com.jorge.gymprogress.dto.AddExerciseToRoutineRequest;
import com.jorge.gymprogress.dto.RoutineExerciseResponse;
import com.jorge.gymprogress.service.RoutineExerciseService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/routines")
public class RoutineExerciseController {

    private final RoutineExerciseService routineExerciseService;

    public RoutineExerciseController(RoutineExerciseService routineExerciseService) {
        this.routineExerciseService = routineExerciseService;
    }

    // Lista los ejercicios que tiene una rutina
    @GetMapping("/{routineId}/exercises")
    public ResponseEntity<List<RoutineExerciseResponse>> obtenerEjerciciosDeRutina(
            @PathVariable Long routineId
    ) {
        List<RoutineExerciseResponse> ejercicios =
                routineExerciseService.obtenerEjerciciosDeRutina(routineId);

        return ResponseEntity.ok(ejercicios);
    }

    // Añade un ejercicio existente a una rutina
    @PostMapping("/{routineId}/exercises/{exerciseId}")
    public ResponseEntity<?> anadirEjercicioARutina(
            @PathVariable Long routineId,
            @PathVariable Long exerciseId,
            @Valid @RequestBody AddExerciseToRoutineRequest request
    ) {
        try {
            return routineExerciseService.anadirEjercicioARutina(routineId, exerciseId, request)
                    .<ResponseEntity<?>>map(ResponseEntity::ok)
                    .orElse(ResponseEntity.notFound().build());
        } catch (IllegalStateException exception) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body(Map.of("mensaje", exception.getMessage()));
        }
    }

    // Elimina un ejercicio de una rutina
    @DeleteMapping("/{routineId}/exercises/{routineExerciseId}")
    public ResponseEntity<Void> eliminarEjercicioDeRutina(
            @PathVariable Long routineId,
            @Pat@@hVariable Long routineExerciseId
    ) {
        boolean eliminado = routineExerciseService.eliminarEjercicioDeRutina(
                routineId,
                routineExerciseId
        );

        if (!eliminado) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.noContent().build();
    }
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: _empty_/PathVariable#