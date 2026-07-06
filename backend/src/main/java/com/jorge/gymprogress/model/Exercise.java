package com.jorge.gymprogress.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "exercises")
public class Exercise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "El nombre del ejercicio es obligatorio")
    @Column(nullable = false)
    private String name;

    @NotNull(message = "El grupo muscular es obligatorio")
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MuscleGroup muscleGroup;

    private String description;

    public Exercise() {
    }

    public Exercise(Long id, String name, MuscleGroup muscleGroup, String description) {
        this.id = id;
        this.name = name;
        this.muscleGroup = muscleGroup;
        this.description = description;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public MuscleGroup getMuscleGroup() {
        return muscleGroup;
    }

    public String getDescription() {
        return description;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setMuscleGroup(MuscleGroup muscleGroup) {
        this.muscleGroup = muscleGroup;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}