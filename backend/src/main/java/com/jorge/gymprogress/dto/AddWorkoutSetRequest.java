package com.jorge.gymprogress.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public class AddWorkoutSetRequest {

    @NotNull(message = "El número de serie es obligatorio")
    @Min(value = 1, message = "El número de serie debe ser mayor que 0")
    private Integer setNumber;

    @NotNull(message = "El peso es obligatorio")
    @Min(value = 0, message = "El peso no puede ser negativo")
    private Double weightKg;

    @NotNull(message = "Las repeticiones son obligatorias")
    @Min(value = 1, message = "Las repeticiones deben ser mayor que 0")
    private Integer repetitions;

    private String notes;

    public Integer getSetNumber() {
        return setNumber;
    }

    public void setSetNumber(Integer setNumber) {
        this.setNumber = setNumber;
    }

    public Double getWeightKg() {
        return weightKg;
    }

    public void setWeightKg(Double weightKg) {
        this.weightKg = weightKg;
    }

    public Integer getRepetitions() {
        return repetitions;
    }

    public void setRepetitions(Integer repetitions) {
        this.repetitions = repetitions;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}