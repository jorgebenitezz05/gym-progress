package com.jorge.gymprogress.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class AddExerciseToRoutineRequest {

    @Min(value = 1, message = "El orden del ejercicio debe ser mayor que 0")
    private Integer exerciseOrder;

    @NotNull(message = "El número de series es obligatorio")
    @Min(value = 1, message = "El número de series debe ser mayor que 0")
    private Integer targetSets;

    @NotBlank(message = "Las repeticiones objetivo son obligatorias")
    private String targetRepetitions;

    @Min(value = 0, message = "El descanso no puede ser negativo")
    private Integer restSeconds;

    private String notes;

    public Integer getExerciseOrder() {
        return exerciseOrder;
    }

    public void setExerciseOrder(Integer exerciseOrder) {
        this.exerciseOrder = exerciseOrder;
    }

    public Integer getTargetSets() {
        return targetSets;
    }

    public void setTargetSets(Integer targetSets) {
        this.targetSets = targetSets;
    }

    public String getTargetRepetitions() {
        return targetRepetitions;
    }

    public void setTargetRepetitions(String targetRepetitions) {
        this.targetRepetitions = targetRepetitions;
    }

    public Integer getRestSeconds() {
        return restSeconds;
    }

    public void setRestSeconds(Integer restSeconds) {
        this.restSeconds = restSeconds;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}