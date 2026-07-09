package com.jorge.gymprogress.service;

import com.jorge.gymprogress.dto.AddWorkoutSetRequest;
import com.jorge.gymprogress.dto.CreateWorkoutSessionRequest;
import com.jorge.gymprogress.dto.WorkoutSessionResponse;
import com.jorge.gymprogress.dto.WorkoutSetResponse;
import com.jorge.gymprogress.model.Exercise;
import com.jorge.gymprogress.model.Routine;
import com.jorge.gymprogress.model.WorkoutSession;
import com.jorge.gymprogress.model.WorkoutSet;
import com.jorge.gymprogress.repository.ExerciseRepository;
import com.jorge.gymprogress.repository.RoutineRepository;
import com.jorge.gymprogress.repository.WorkoutSessionRepository;
import com.jorge.gymprogress.repository.WorkoutSetRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class WorkoutService {

    private final WorkoutSessionRepository workoutSessionRepository;
    private final WorkoutSetRepository workoutSetRepository;
    private final RoutineRepository routineRepository;
    private final ExerciseRepository exerciseRepository;

    public WorkoutService(
            WorkoutSessionRepository workoutSessionRepository,
            WorkoutSetRepository workoutSetRepository,
            RoutineRepository routineRepository,
            ExerciseRepository exerciseRepository
    ) {
        this.workoutSessionRepository = workoutSessionRepository;
        this.workoutSetRepository = workoutSetRepository;
        this.routineRepository = routineRepository;
        this.exerciseRepository = exerciseRepository;
    }

    // Crea una nueva sesión de entrenamiento a partir de una rutina
    public Optional<WorkoutSessionResponse> crearEntrenamiento(CreateWorkoutSessionRequest request) {
        Optional<Routine> rutinaOptional = routineRepository.findById(request.getRoutineId());

        if (rutinaOptional.isEmpty()) {
            return Optional.empty();
        }

        WorkoutSession workoutSession = new WorkoutSession();
        workoutSession.setRoutine(rutinaOptional.get());
        workoutSession.setWorkoutDate(request.getWorkoutDate());
        workoutSession.setNotes(request.getNotes());

        WorkoutSession guardado = workoutSessionRepository.save(workoutSession);

        return Optional.of(convertirSesionARespuesta(guardado));
    }

    // Lista todos los entrenamientos
    public List<WorkoutSessionResponse> obtenerTodosLosEntrenamientos() {
        return workoutSessionRepository.findAllByOrderByWorkoutDateDesc()
                .stream()
                .map(this::convertirSesionARespuesta)
                .toList();
    }

    // Busca un entrenamiento por id
    public Optional<WorkoutSessionResponse> obtenerEntrenamientoPorId(Long workoutSessionId) {
        return workoutSessionRepository.findById(workoutSessionId)
                .map(this::convertirSesionARespuesta);
    }

    // Añade una serie a un entrenamiento
    public Optional<WorkoutSetResponse> anadirSerieAEntrenamiento(
            Long workoutSessionId,
            Long exerciseId,
            AddWorkoutSetRequest request
    ) {
        Optional<WorkoutSession> entrenamientoOptional =
                workoutSessionRepository.findById(workoutSessionId);

        Optional<Exercise> ejercicioOptional =
                exerciseRepository.findById(exerciseId);

        if (entrenamientoOptional.isEmpty() || ejercicioOptional.isEmpty()) {
            return Optional.empty();
        }

        WorkoutSet workoutSet = new WorkoutSet();
        workoutSet.setWorkoutSession(entrenamientoOptional.get());
        workoutSet.setExercise(ejercicioOptional.get());
        workoutSet.setSetNumber(request.getSetNumber());
        workoutSet.setWeightKg(request.getWeightKg());
        workoutSet.setRepetitions(request.getRepetitions());
        workoutSet.setNotes(request.getNotes());

        WorkoutSet guardado = workoutSetRepository.save(workoutSet);

        return Optional.of(convertirSerieARespuesta(guardado));
    }

    // Lista las series de un entrenamiento concreto
    public List<WorkoutSetResponse> obtenerSeriesDeEntrenamiento(Long workoutSessionId) {
        return workoutSetRepository.findByWorkoutSessionIdOrderBySetNumberAsc(workoutSessionId)
                .stream()
                .map(this::convertirSerieARespuesta)
                .toList();
    }

    private WorkoutSessionResponse convertirSesionARespuesta(WorkoutSession workoutSession) {
        return new WorkoutSessionResponse(
                workoutSession.getId(),
                workoutSession.getRoutine().getId(),
                workoutSession.getRoutine().getName(),
                workoutSession.getWorkoutDate(),
                workoutSession.getNotes(),
                workoutSession.getCreatedAt()
        );
    }

    private WorkoutSetResponse convertirSerieARespuesta(WorkoutSet workoutSet) {
        return new WorkoutSetResponse(
                workoutSet.getId(),
                workoutSet.getWorkoutSession().getId(),
                workoutSet.getExercise().getId(),
                workoutSet.getExercise().getName(),
                workoutSet.getExercise().getMuscleGroup(),
                workoutSet.getSetNumber(),
                workoutSet.getWeightKg(),
                workoutSet.getRepetitions(),
                workoutSet.calcularVolumen(),
                workoutSet.getNotes()
        );
    }
}