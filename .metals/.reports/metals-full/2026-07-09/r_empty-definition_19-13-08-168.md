error id: file:///C:/Users/jorge/OneDrive/Documentos/Proyecto%20GYM/gym-progress/backend/src/main/java/com/jorge/gymprogress/repository/RoutineExerciseRepository.java:_empty_/RoutineExercise#
file:///C:/Users/jorge/OneDrive/Documentos/Proyecto%20GYM/gym-progress/backend/src/main/java/com/jorge/gymprogress/repository/RoutineExerciseRepository.java
empty definition using pc, found symbol in pc: _empty_/RoutineExercise#
empty definition using semanticdb
empty definition using fallback
non-local guesses:

offset: 347
uri: file:///C:/Users/jorge/OneDrive/Documentos/Proyecto%20GYM/gym-progress/backend/src/main/java/com/jorge/gymprogress/repository/RoutineExerciseRepository.java
text:
```scala
package com.jorge.gymprogress.repository;

import com.jorge.gymprogress.model.RoutineExercise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RoutineExerciseRepository extends JpaRepository<R@@outineExercise, Long> {

    List<RoutineExercise> findByRoutineIdOrderByExerciseOrderAsc(Long routineId);

    Optional<RoutineExercise> findByIdAndRoutineId(Long id, Long routineId);

    boolean existsByRoutineIdAndExerciseId(Long routineId, Long exerciseId);

    long countByRoutineId(Long routineId);
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: _empty_/RoutineExercise#