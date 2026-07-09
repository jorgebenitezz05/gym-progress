package com.jorge.gymprogress.repository;

import com.jorge.gymprogress.model.RoutineExercise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RoutineExerciseRepository extends JpaRepository<RoutineExercise, Long> {

    List<RoutineExercise> findByRoutineIdOrderByExerciseOrderAsc(Long routineId);

    Optional<RoutineExercise> findByIdAndRoutineId(Long id, Long routineId);

    boolean existsByRoutineIdAndExerciseId(Long routineId, Long exerciseId);

    long countByRoutineId(Long routineId);
}