package com.jorge.gymprogress.dto;

public class SummaryStatisticsResponse {

    private Long totalWorkouts;
    private Long totalSets;
    private Long totalExercises;
    private Long totalRoutines;
    private Double totalVolume;

    public SummaryStatisticsResponse(
            Long totalWorkouts,
            Long totalSets,
            Long totalExercises,
            Long totalRoutines,
            Double totalVolume
    ) {
        this.totalWorkouts = totalWorkouts;
        this.totalSets = totalSets;
        this.totalExercises = totalExercises;
        this.totalRoutines = totalRoutines;
        this.totalVolume = totalVolume;
    }

    public Long getTotalWorkouts() {
        return totalWorkouts;
    }

    public Long getTotalSets() {
        return totalSets;
    }

    public Long getTotalExercises() {
        return totalExercises;
    }

    public Long getTotalRoutines() {
        return totalRoutines;
    }

    public Double getTotalVolume() {
        return totalVolume;
    }
}