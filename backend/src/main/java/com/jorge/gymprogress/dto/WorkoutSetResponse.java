package com.jorge.gymprogress.dto;

import com.jorge.gymprogress.model.MuscleGroup;

public class WorkoutSetResponse {

    private Long id;
    private Long workoutSessionId;
    private Long exerciseId;
    private String exerciseName;
    private MuscleGroup muscleGroup;
    private Integer setNumber;
    private Double weightKg;
    private Integer repetitions;
    private Double volume;
    private String notes;

    public WorkoutSetResponse(
            Long id,
            Long workoutSessionId,
            Long exerciseId,
            String exerciseName,
            MuscleGroup muscleGroup,
            Integer setNumber,
            Double weightKg,
            Integer repetitions,
            Double volume,
            String notes
    ) {
        this.id = id;
        this.workoutSessionId = workoutSessionId;
        this.exerciseId = exerciseId;
        this.exerciseName = exerciseName;
        this.muscleGroup = muscleGroup;
        this.setNumber = setNumber;
        this.weightKg = weightKg;
        this.repetitions = repetitions;
        this.volume = volume;
        this.notes = notes;
    }

    public Long getId() {
        return id;
    }

    public Long getWorkoutSessionId() {
        return workoutSessionId;
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

    public Integer getSetNumber() {
        return setNumber;
    }

    public Double getWeightKg() {
        return weightKg;
    }

    public Integer getRepetitions() {
        return repetitions;
    }

    public Double getVolume() {
        return volume;
    }

    public String getNotes() {
        return notes;
    }
}