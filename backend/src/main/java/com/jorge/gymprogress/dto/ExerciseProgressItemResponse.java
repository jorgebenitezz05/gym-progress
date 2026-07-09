package com.jorge.gymprogress.dto;

import java.time.LocalDate;

public class ExerciseProgressItemResponse {

    private LocalDate workoutDate;
    private Integer setNumber;
    private Double weightKg;
    private Integer repetitions;
    private Double volume;

    public ExerciseProgressItemResponse(
            LocalDate workoutDate,
            Integer setNumber,
            Double weightKg,
            Integer repetitions,
            Double volume
    ) {
        this.workoutDate = workoutDate;
        this.setNumber = setNumber;
        this.weightKg = weightKg;
        this.repetitions = repetitions;
        this.volume = volume;
    }

    public LocalDate getWorkoutDate() {
        return workoutDate;
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
}