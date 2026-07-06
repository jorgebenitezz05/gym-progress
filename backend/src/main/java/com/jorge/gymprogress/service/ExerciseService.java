package com.jorge.gymprogress.service;

import com.jorge.gymprogress.model.Exercise;
import com.jorge.gymprogress.repository.ExerciseRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ExerciseService {

    private final ExerciseRepository exerciseRepository;

    public ExerciseService(ExerciseRepository exerciseRepository) {
        this.exerciseRepository = exerciseRepository;
    }

    // Obtiene todos los ejercicios guardados
    public List<Exercise> obtenerTodosLosEjercicios() {
        return exerciseRepository.findAll();
    }

    // Busca un ejercicio por su id
    public Optional<Exercise> obtenerEjercicioPorId(Long id) {
        return exerciseRepository.findById(id);
    }

    // Guarda un nuevo ejercicio
    public Exercise crearEjercicio(Exercise exercise) {
        return exerciseRepository.save(exercise);
    }

    // Actualiza un ejercicio existente
    public Optional<Exercise> actualizarEjercicio(Long id, Exercise exerciseActualizado) {
        return exerciseRepository.findById(id).map(exercise -> {
            exercise.setName(exerciseActualizado.getName());
            exercise.setMuscleGroup(exerciseActualizado.getMuscleGroup());
            exercise.setDescription(exerciseActualizado.getDescription());

            return exerciseRepository.save(exercise);
        });
    }

    // Elimina un ejercicio por id
    public boolean eliminarEjercicio(Long id) {
        if (!exerciseRepository.existsById(id)) {
            return false;
        }

        exerciseRepository.deleteById(id);
        return true;
    }
}