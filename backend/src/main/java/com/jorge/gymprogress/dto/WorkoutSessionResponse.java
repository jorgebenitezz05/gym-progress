package com.jorge.gymprogress.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class WorkoutSessionResponse {

    private Long id;
    private Long routineId;
    private String routineName;
    private LocalDate workoutDate;
    private String notes;
    private LocalDateTime createdAt;

    public WorkoutSessionResponse(
            Long id,
            Long routineId,
            String routineName,
            LocalDate workoutDate,
            String notes,
            LocalDateTime createdAt
    ) {
        this.id = id;
        this.routineId = routineId;
        this.routineName = routineName;
        this.workoutDate = workoutDate;
        this.notes = notes;
        this.createdAt = createdAt;
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

    public LocalDate getWorkoutDate() {
        return workoutDate;
    }

    public String getNotes() {
        return notes;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
}