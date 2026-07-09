package com.jorge.gymprogress.service;

import com.jorge.gymprogress.dto.ExerciseProgressItemResponse;
import com.jorge.gymprogress.dto.ExerciseProgressResponse;
import com.jorge.gymprogress.dto.SummaryStatisticsResponse;
import com.jorge.gymprogress.model.Exercise;
import com.jorge.gymprogress.model.WorkoutSet;
import com.jorge.gymprogress.repository.ExerciseRepository;
import com.jorge.gymprogress.repository.RoutineRepository;
import com.jorge.gymprogress.repository.WorkoutSessionRepository;
import com.jorge.gymprogress.repository.WorkoutSetRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StatisticsService {

    private final WorkoutSessionRepository workoutSessionRepository;
    private final WorkoutSetRepository workoutSetRepository;
    private final ExerciseRepository exerciseRepository;
    private final RoutineRepository routineRepository;

    public StatisticsService(
            WorkoutSessionRepository workoutSessionRepository,
            WorkoutSetRepository workoutSetRepository,
            ExerciseRepository exerciseRepository,
            RoutineRepository routineRepository
    ) {
        this.workoutSessionRepository = workoutSessionRepository;
        this.workoutSetRepository = workoutSetRepository;
        this.exerciseRepository = exerciseRepository;
        this.routineRepository = routineRepository;
    }

    // Obtiene un resumen general de la actividad registrada
    public SummaryStatisticsResponse obtenerResumenGeneral() {
        Long totalWorkouts = workoutSessionRepository.count();
        Long totalSets = workoutSetRepository.count();
        Long totalExercises = exerciseRepository.count();
        Long totalRoutines = routineRepository.count();
        Double totalVolume = workoutSetRepository.calcularVolumenTotal();

        return new SummaryStatisticsResponse(
                totalWorkouts,
                totalSets,
                totalExercises,
                totalRoutines,
                totalVolume
        );
    }

    // Obtiene el progreso de un ejercicio concreto
    public Optional<ExerciseProgressResponse> obtenerProgresoPorEjercicio(Long exerciseId) {
        Optional<Exercise> ejercicioOptional = exerciseRepository.findById(exerciseId);

        if (ejercicioOptional.isEmpty()) {
            return Optional.empty();
        }

        Exercise exercise = ejercicioOptional.get();

        Double maxWeightKg = workoutSetRepository.obtenerPesoMaximoPorEjercicio(exerciseId);
        Long totalSets = workoutSetRepository.countByExerciseId(exerciseId);
        Double totalVolume = workoutSetRepository.calcularVolumenTotalPorEjercicio(exerciseId);

        List<ExerciseProgressItemResponse> history = workoutSetRepository.obtenerHistorialPorEjercicio(exerciseId)
                .stream()
                .map(this::convertirAElementoDeProgreso)
                .toList();

        ExerciseProgressResponse response = new ExerciseProgressResponse(
                exercise.getId(),
                exercise.getName(),
                exercise.getMuscleGroup(),
                maxWeightKg,
                totalSets,
                totalVolume,
                history
        );

        return Optional.of(response);
    }

    private ExerciseProgressItemResponse convertirAElementoDeProgreso(WorkoutSet workoutSet) {
        return new ExerciseProgressItemResponse(
                workoutSet.getWorkoutSession().getWorkoutDate(),
                workoutSet.getSetNumber(),
                workoutSet.getWeightKg(),
                workoutSet.getRepetitions(),
                workoutSet.calcularVolumen()
        );
    }
}