error id: file:///C:/Users/jorge/OneDrive/Documentos/Proyecto%20GYM/gym-progress/backend/src/main/java/com/jorge/gymprogress/service/RoutineExerciseService.java:_empty_/RoutineExercise#getTargetSets#
file:///C:/Users/jorge/OneDrive/Documentos/Proyecto%20GYM/gym-progress/backend/src/main/java/com/jorge/gymprogress/service/RoutineExerciseService.java
empty definition using pc, found symbol in pc: _empty_/RoutineExercise#getTargetSets#
empty definition using semanticdb
empty definition using fallback
non-local guesses:

offset: 4378
uri: file:///C:/Users/jorge/OneDrive/Documentos/Proyecto%20GYM/gym-progress/backend/src/main/java/com/jorge/gymprogress/service/RoutineExerciseService.java
text:
```scala
package com.jorge.gymprogress.service;

import com.jorge.gymprogress.dto.AddExerciseToRoutineRequest;
import com.jorge.gymprogress.dto.RoutineExerciseResponse;
import com.jorge.gymprogress.model.Exercise;
import com.jorge.gymprogress.model.Routine;
import com.jorge.gymprogress.model.RoutineExercise;
import com.jorge.gymprogress.repository.ExerciseRepository;
import com.jorge.gymprogress.repository.RoutineExerciseRepository;
import com.jorge.gymprogress.repository.RoutineRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoutineExerciseService {

    private final RoutineExerciseRepository routineExerciseRepository;
    private final RoutineRepository routineRepository;
    private final ExerciseRepository exerciseRepository;

    public RoutineExerciseService(
            RoutineExerciseRepository routineExerciseRepository,
            RoutineRepository routineRepository,
            ExerciseRepository exerciseRepository
    ) {
        this.routineExerciseRepository = routineExerciseRepository;
        this.routineRepository = routineRepository;
        this.exerciseRepository = exerciseRepository;
    }

    // Obtiene todos los ejercicios de una rutina concreta
    public List<RoutineExerciseResponse> obtenerEjerciciosDeRutina(Long routineId) {
        return routineExerciseRepository.findByRoutineIdOrderByExerciseOrderAsc(routineId)
                .stream()
                .map(this::convertirARespuesta)
                .toList();
    }

    // Añade un ejercicio existente a una rutina existente
    public Optional<RoutineExerciseResponse> anadirEjercicioARutina(
            Long routineId,
            Long exerciseId,
            AddExerciseToRoutineRequest request
    ) {
        Optional<Routine> rutinaOptional = routineRepository.findById(routineId);
        Optional<Exercise> ejercicioOptional = exerciseRepository.findById(exerciseId);

        if (rutinaOptional.isEmpty() || ejercicioOptional.isEmpty()) {
            return Optional.empty();
        }

        if (routineExerciseRepository.existsByRoutineIdAndExerciseId(routineId, exerciseId)) {
            throw new IllegalStateException("Este ejercicio ya está añadido a la rutina");
        }

        RoutineExercise routineExercise = new RoutineExercise();

        routineExercise.setRoutine(rutinaOptional.get());
        routineExercise.setExercise(ejercicioOptional.get());

        if (request.getExerciseOrder() == null) {
            int siguienteOrden = (int) routineExerciseRepository.countByRoutineId(routineId) + 1;
            routineExercise.setExerciseOrder(siguienteOrden);
        } else {
            routineExercise.setExerciseOrder(request.getExerciseOrder());
        }

        routineExercise.setTargetSets(request.getTargetSets());
        routineExercise.setTargetRepetitions(request.getTargetRepetitions());
        routineExercise.setRestSeconds(request.getRestSeconds());
        routineExercise.setNotes(request.getNotes());

        RoutineExercise guardado = routineExerciseRepository.save(routineExercise);

        return Optional.of(convertirARespuesta(guardado));
    }

    // Elimina un ejercicio de una rutina
    public boolean eliminarEjercicioDeRutina(Long routineId, Long routineExerciseId) {
        Optional<RoutineExercise> routineExerciseOptional =
                routineExerciseRepository.findByIdAndRoutineId(routineExerciseId, routineId);

        if (routineExerciseOptional.isEmpty()) {
            return false;
        }

        routineExerciseRepository.delete(routineExerciseOptional.get());
        return true;
    }

    // Convierte la entidad en una respuesta más limpia para la API
    private RoutineExerciseResponse convertirARespuesta(RoutineExercise routineExercise) {
        return new RoutineExerciseResponse(
                routineExercise.getId(),
                routineExercise.getRoutine().getId(),
                routineExercise.getRoutine().getName(),
                routineExercise.getExercise().getId(),
                routineExercise.getExercise().getName(),
                routineExercise.getExercise().getMuscleGroup(),
                routineExercise.getExerciseOrder(),
                routineExercise.g@@etTargetSets(),
                routineExercise.getTargetRepetitions(),
                routineExercise.getRestSeconds(),
                routineExercise.getNotes()
        );
    }
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: _empty_/RoutineExercise#getTargetSets#