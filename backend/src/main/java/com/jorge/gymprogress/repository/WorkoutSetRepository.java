package com.jorge.gymprogress.repository;

import com.jorge.gymprogress.model.WorkoutSet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface WorkoutSetRepository extends JpaRepository<WorkoutSet, Long> {

    List<WorkoutSet> findByWorkoutSessionIdOrderBySetNumberAsc(Long workoutSessionId);

    long countByExerciseId(Long exerciseId);

    // Calcula el volumen total de todos los entrenamientos
    @Query("SELECT COALESCE(SUM(ws.weightKg * ws.repetitions), 0.0) FROM WorkoutSet ws")
    Double calcularVolumenTotal();

    // Calcula el peso máximo usado en un ejercicio concreto
    @Query("SELECT COALESCE(MAX(ws.weightKg), 0.0) FROM WorkoutSet ws WHERE ws.exercise.id = :exerciseId")
    Double obtenerPesoMaximoPorEjercicio(@Param("exerciseId") Long exerciseId);

    // Calcula el volumen total de un ejercicio concreto
    @Query("SELECT COALESCE(SUM(ws.weightKg * ws.repetitions), 0.0) FROM WorkoutSet ws WHERE ws.exercise.id = :exerciseId")
    Double calcularVolumenTotalPorEjercicio(@Param("exerciseId") Long exerciseId);

    // Obtiene el historial de series de un ejercicio ordenado por fecha
    @Query("""
            SELECT ws
            FROM WorkoutSet ws
            WHERE ws.exercise.id = :exerciseId
            ORDER BY ws.workoutSession.workoutDate ASC, ws.setNumber ASC
            """)
    List<WorkoutSet> obtenerHistorialPorEjercicio(@Param("exerciseId") Long exerciseId);
}