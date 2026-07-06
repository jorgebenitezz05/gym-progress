package com.jorge.gymprogress.service;

import com.jorge.gymprogress.model.Routine;
import com.jorge.gymprogress.repository.RoutineRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoutineService {

    private final RoutineRepository routineRepository;

    public RoutineService(RoutineRepository routineRepository) {
        this.routineRepository = routineRepository;
    }

    // Obtiene todas las rutinas guardadas
    public List<Routine> obtenerTodasLasRutinas() {
        return routineRepository.findAll();
    }

    // Busca una rutina por su id
    public Optional<Routine> obtenerRutinaPorId(Long id) {
        return routineRepository.findById(id);
    }

    // Guarda una nueva rutina
    public Routine crearRutina(Routine routine) {
        return routineRepository.save(routine);
    }

    // Actualiza una rutina existente
    public Optional<Routine> actualizarRutina(Long id, Routine rutinaActualizada) {
        return routineRepository.findById(id).map(routine -> {
            routine.setName(rutinaActualizada.getName());
            routine.setDescription(rutinaActualizada.getDescription());

            return routineRepository.save(routine);
        });
    }

    // Elimina una rutina por id
    public boolean eliminarRutina(Long id) {
        if (!routineRepository.existsById(id)) {
            return false;
        }

        routineRepository.deleteById(id);
        return true;
    }
}