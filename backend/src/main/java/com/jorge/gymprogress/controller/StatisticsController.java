package com.jorge.gymprogress.controller;

import com.jorge.gymprogress.dto.ExerciseProgressResponse;
import com.jorge.gymprogress.dto.SummaryStatisticsResponse;
import com.jorge.gymprogress.service.StatisticsService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/statistics")
public class StatisticsController {

    private final StatisticsService statisticsService;

    public StatisticsController(StatisticsService statisticsService) {
        this.statisticsService = statisticsService;
    }

    // Devuelve un resumen general de los entrenamientos
    @GetMapping("/summary")
    public SummaryStatisticsResponse obtenerResumenGeneral() {
        return statisticsService.obtenerResumenGeneral();
    }

    // Devuelve el progreso de un ejercicio concreto
    @GetMapping("/exercises/{exerciseId}/progress")
    public ResponseEntity<ExerciseProgressResponse> obtenerProgresoPorEjercicio(
            @PathVariable Long exerciseId
    ) {
        return statisticsService.obtenerProgresoPorEjercicio(exerciseId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}