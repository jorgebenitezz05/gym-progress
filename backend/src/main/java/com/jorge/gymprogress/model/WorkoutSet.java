package com.jorge.gymprogress.model;

import jakarta.persistence.*;

@Entity
@Table(name = "workout_sets")
public class WorkoutSet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Entrenamiento al que pertenece esta serie
    @ManyToOne(optional = false)
    @JoinColumn(name = "workout_session_id", nullable = false)
    private WorkoutSession workoutSession;

    // Ejercicio realizado en esta serie
    @ManyToOne(optional = false)
    @JoinColumn(name = "exercise_id", nullable = false)
    private Exercise exercise;

    @Column(nullable = false)
    private Integer setNumber;

    @Column(nullable = false)
    private Double weightKg;

    @Column(nullable = false)
    private Integer repetitions;

    private String notes;

    public WorkoutSet() {
    }

    public Double calcularVolumen() {
        return weightKg * repetitions;
    }

    public Long getId() {
        return id;
    }

    public WorkoutSession getWorkoutSession() {
        return workoutSession;
    }

    public Exercise getExercise() {
        return exercise;
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

    public String getNotes() {
        return notes;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setWorkoutSession(WorkoutSession workoutSession) {
        this.workoutSession = workoutSession;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
    }

    public void setSetNumber(Integer setNumber) {
        this.setNumber = setNumber;
    }

    public void setWeightKg(Double weightKg) {
        this.weightKg = weightKg;
    }

    public void setRepetitions(Integer repetitions) {
        this.repetitions = repetitions;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}