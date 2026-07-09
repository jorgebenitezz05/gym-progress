package com.jorge.gymprogress.controller;

import com.jorge.gymprogress.dto.AddWorkoutSetRequest;
import com.jorge.gymprogress.dto.CreateWorkoutSessionRequest;
import com.jorge.gymprogress.dto.WorkoutSessionResponse;
import com.jorge.gymprogress.dto.WorkoutSetResponse;
import com.jorge.gymprogress.service.WorkoutService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/workouts")
public class WorkoutController {

    private final WorkoutService workoutService;

    public WorkoutController(WorkoutService workoutService) {
        this.workoutService = workoutService;
    }

    // Crea una nueva sesión de entrenamiento
    @PostMapping
    public ResponseEntity<WorkoutSessionResponse> crearEntrenamiento(
            @RequestBody CreateWorkoutSessionRequest request
    ) {
        return workoutService.crearEntrenamiento(request)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Lista todos los entrenamientos
    @GetMapping
    public List<WorkoutSessionResponse> obtenerTodosLosEntrenamientos() {
        return workoutService.obtenerTodosLosEntrenamientos();
    }

    // Obtiene un entrenamiento por id
    @GetMapping("/{workoutSessionId}")
    public ResponseEntity<WorkoutSessionResponse> obtenerEntrenamientoPorId(
            @PathVariable Long workoutSessionId
    ) {
        return workoutService.obtenerEntrenamientoPorId(workoutSessionId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Añade una serie a un entrenamiento
    @PostMapping("/{workoutSessionId}/exercises/{exerciseId}/sets")
    public ResponseEntity<WorkoutSetResponse> anadirSerieAEntrenamiento(
            @PathVariable Long workoutSessionId,
            @PathVariable Long exerciseId,
            @Valid @RequestBody AddWorkoutSetRequest request
    ) {
        return workoutService.anadirSerieAEntrenamiento(workoutSessionId, exerciseId, request)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Lista las series de un entrenamiento
    @GetMapping("/{workoutSessionId}/sets")
    public List<WorkoutSetResponse> obtenerSeriesDeEntrenamiento(
            @PathVariable Long workoutSessionId
    ) {
        return workoutService.obtenerSeriesDeEntrenamiento(workoutSessionId);
    }
}