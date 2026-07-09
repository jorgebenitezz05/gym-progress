package com.jorge.gymprogress.dto;

import com.jorge.gymprogress.model.MuscleGroup;

import java.util.List;

public class ExerciseProgressResponse {

    private Long exerciseId;
    private String exerciseName;
    private MuscleGroup muscleGroup;
    private Double maxWeightKg;
    private Long totalSets;
    private Double totalVolume;
    private List<ExerciseProgressItemResponse> history;

    public ExerciseProgressResponse(
            Long exerciseId,
            String exerciseName,
            MuscleGroup muscleGroup,
            Double maxWeightKg,
            Long totalSets,
            Double totalVolume,
            List<ExerciseProgressItemResponse> history
    ) {
        this.exerciseId = exerciseId;
        this.exerciseName = exerciseName;
        this.muscleGroup = muscleGroup;
        this.maxWeightKg = maxWeightKg;
        this.totalSets = totalSets;
        this.totalVolume = totalVolume;
        this.history = history;
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

    public Double getMaxWeightKg() {
        return maxWeightKg;
    }

    public Long getTotalSets() {
        return totalSets;
    }

    public Double getTotalVolume() {
        return totalVolume;
    }

    public List<ExerciseProgressItemResponse> getHistory() {
        return history;
    }
}