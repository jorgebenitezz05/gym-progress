package com.jorge.gymprogress.model;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "workout_sessions")
public class WorkoutSession {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Rutina que se ha realizado en este entrenamiento
    @ManyToOne(optional = false)
    @JoinColumn(name = "routine_id", nullable = false)
    private Routine routine;

    @Column(nullable = false)
    private LocalDate workoutDate;

    private String notes;

    @Column(nullable = false)
    private LocalDateTime createdAt;

    public WorkoutSession() {
    }

    @PrePersist
    public void asignarFechaCreacion() {
        this.createdAt = LocalDateTime.now();

        if (this.workoutDate == null) {
            this.workoutDate = LocalDate.now();
        }
    }

    public Long getId() {
        return id;
    }

    public Routine getRoutine() {
        return routine;
    }

    public LocalDate getWorkoutDate() {
        return workoutDate;
    }

    public String getNotes() {
        return notes;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setRoutine(Routine routine) {
        this.routine = routine;
    }

    public void setWorkoutDate(LocalDate workoutDate) {
        this.workoutDate = workoutDate;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}