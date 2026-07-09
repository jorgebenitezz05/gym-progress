package com.jorge.gymprogress.model;

import jakarta.persistence.*;

@Entity
@Table(name = "routine_exercises")
public class RoutineExercise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Rutina a la que pertenece este ejercicio
    @ManyToOne(optional = false)
    @JoinColumn(name = "routine_id", nullable = false)
    private Routine routine;

    // Ejercicio que se añade a la rutina
    @ManyToOne(optional = false)
    @JoinColumn(name = "exercise_id", nullable = false)
    private Exercise exercise;

    // Orden en el que aparece el ejercicio dentro de la rutina
    @Column(name = "exercise_order")
    private Integer exerciseOrder;

    @Column(nullable = false)
    private Integer targetSets;

    @Column(nullable = false)
    private String targetRepetitions;

    private Integer restSeconds;

    private String notes;

    public RoutineExercise() {
    }

    public Long getId() {
        return id;
    }

    public Routine getRoutine() {
        return routine;
    }

    public Exercise getExercise() {
        return exercise;
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

    public void setId(Long id) {
        this.id = id;
    }

    public void setRoutine(Routine routine) {
        this.routine = routine;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
    }

    public void setExerciseOrder(Integer exerciseOrder) {
        this.exerciseOrder = exerciseOrder;
    }

    public void setTargetSets(Integer targetSets) {
        this.targetSets = targetSets;
    }

    public void setTargetRepetitions(String targetRepetitions) {
        this.targetRepetitions = targetRepetitions;
    }

    public void setRestSeconds(Integer restSeconds) {
        this.restSeconds = restSeconds;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}