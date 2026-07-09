package com.jorge.gymprogress.dto;

import com.jorge.gymprogress.model.MuscleGroup;

public class RoutineExerciseResponse {

    private Long id;

    private Long routineId;
    private String routineName;

    private Long exerciseId;
    private String exerciseName;
    private MuscleGroup muscleGroup;

    private Integer exerciseOrder;
    private Integer targetSets;
    private String targetRepetitions;
    private Integer restSeconds;
    private String notes;

    public RoutineExerciseResponse() {
    }

    public RoutineExerciseResponse(
            Long id,
            Long routineId,
            String routineName,
            Long exerciseId,
            String exerciseName,
            MuscleGroup muscleGroup,
            Integer exerciseOrder,
            Integer targetSets,
            String targetRepetitions,
            Integer restSeconds,
            String notes
    ) {
        this.id = id;
        this.routineId = routineId;
        this.routineName = routineName;
        this.exerciseId = exerciseId;
        this.exerciseName = exerciseName;
        this.muscleGroup = muscleGroup;
        this.exerciseOrder = exerciseOrder;
        this.targetSets = targetSets;
        this.targetRepetitions = targetRepetitions;
        this.restSeconds = restSeconds;
        this.notes = notes;
    }

    public Long getId() {
        return id;
    }

    public Long getRoutineId() {
        return routineId;
    }

    public String getRoutineName() {
        return routineName;
    }

    public Long getExerciseId() {
        return exerciseId;
    }

    public String getExerciseName() {
        return exerciseName;
    }

    public MuscleGroup getMuscleGroup() {
        return muscleGroup;
    }

    public Integer getExerciseOrder() {
        return exerciseOrder;
    }

    public Integer getTargetSets() {
        return targetSets;
    }

    public String getTargetRepetitions() {
        return targetRepetitions;
    }

    public Integer getRestSeconds() {
        return restSeconds;
    }

    public String getNotes() {
        return notes;
    }
}