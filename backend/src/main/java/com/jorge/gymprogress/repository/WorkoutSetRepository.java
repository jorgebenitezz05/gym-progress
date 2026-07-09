package com.jorge.gymprogress.repository;

import com.jorge.gymprogress.model.WorkoutSet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WorkoutSetRepository extends JpaRepository<WorkoutSet, Long> {

    List<WorkoutSet> findByWorkoutSessionIdOrderBySetNumberAsc(Long workoutSessionId);
}