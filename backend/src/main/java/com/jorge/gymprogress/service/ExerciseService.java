package com.jorge.gymprogress.service;

import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.jorge.gymprogress.model.Exercise;
import com.jorge.gymprogress.model.MuscleGroup;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class ExerciseService {

    private static final String EXERCISES_COLLECTION = "exercises";
    private static final String COUNTERS_COLLECTION = "counters";
    private static final String EXERCISES_COUNTER_DOCUMENT = "exercises";

    private final Firestore firestore;

    public ExerciseService(Firestore firestore) {
        this.firestore = firestore;
    }

    // Obtiene todos los ejercicios guardados en Firebase
    public List<Exercise> obtenerTodosLosEjercicios() {
        try {
            QuerySnapshot querySnapshot = firestore.collection(EXERCISES_COLLECTION)
                    .orderBy("id")
                    .get()
                    .get();

            return querySnapshot.getDocuments()
                    .stream()
                    .map(this::convertirDocumentoAEjercicio)
                    .toList();

        } catch (Exception e) {
            throw new RuntimeException("Error al obtener los ejercicios desde Firebase", e);
        }
    }

    // Busca un ejercicio por su id en Firebase
    public Optional<Exercise> obtenerEjercicioPorId(Long id) {
        try {
            DocumentSnapshot documentSnapshot = firestore.collection(EXERCISES_COLLECTION)
                    .document(id.toString())
                    .get()
                    .get();

            if (!documentSnapshot.exists()) {
                return Optional.empty();
            }

            return Optional.of(convertirDocumentoAEjercicio(documentSnapshot));

        } catch (Exception e) {
            throw new RuntimeException("Error al buscar el ejercicio en Firebase", e);
        }
    }

    // Guarda un nuevo ejercicio en Firebase
    public Exercise crearEjercicio(Exercise exercise) {
        try {
            Long nuevoId = obtenerSiguienteId();

            exercise.setId(nuevoId);

            Map<String, Object> datos = convertirEjercicioAMap(exercise);

            firestore.collection(EXERCISES_COLLECTION)
                    .document(nuevoId.toString())
                    .set(datos)
                    .get();

            return exercise;

        } catch (Exception e) {
            throw new RuntimeException("Error al crear el ejercicio en Firebase", e);
        }
    }

    // Actualiza un ejercicio existente en Firebase
    public Optional<Exercise> actualizarEjercicio(Long id, Exercise exerciseActualizado) {
        try {
            DocumentReference documentReference = firestore.collection(EXERCISES_COLLECTION)
                    .document(id.toString());

            DocumentSnapshot documentSnapshot = documentReference.get().get();

            if (!documentSnapshot.exists()) {
                return Optional.empty();
            }

            exerciseActualizado.setId(id);

            Map<String, Object> datos = convertirEjercicioAMap(exerciseActualizado);

            documentReference.set(datos).get();

            return Optional.of(exerciseActualizado);

        } catch (Exception e) {
            throw new RuntimeException("Error al actualizar el ejercicio en Firebase", e);
        }
    }

    // Elimina un ejercicio por id en Firebase
    public boolean eliminarEjercicio(Long id) {
        try {
            DocumentReference documentReference = firestore.collection(EXERCISES_COLLECTION)
                    .document(id.toString());

            DocumentSnapshot documentSnapshot = documentReference.get().get();

            if (!documentSnapshot.exists()) {
                return false;
            }

            documentReference.delete().get();

            return true;

        } catch (Exception e) {
            throw new RuntimeException("Error al eliminar el ejercicio en Firebase", e);
        }
    }

    // Genera ids numéricos para mantener compatibilidad con Flutter y los endpoints actuales
    private Long obtenerSiguienteId() {
        try {
            DocumentReference counterReference = firestore.collection(COUNTERS_COLLECTION)
                    .document(EXERCISES_COUNTER_DOCUMENT);

            return firestore.runTransaction(transaction -> {
                DocumentSnapshot snapshot = transaction.get(counterReference).get();

                Long siguienteId = 1L;

                if (snapshot.exists() && snapshot.getLong("nextId") != null) {
                    siguienteId = snapshot.getLong("nextId");
                }

                Map<String, Object> datosContador = new HashMap<>();
                datosContador.put("nextId", siguienteId + 1);

                transaction.set(counterReference, datosContador);

                return siguienteId;
            }).get();

        } catch (Exception e) {
            throw new RuntimeException("Error al generar el siguiente id de ejercicio", e);
        }
    }

    // Convierte un documento de Firebase en un objeto Exercise
    private Exercise convertirDocumentoAEjercicio(DocumentSnapshot documentSnapshot) {
        Long id = documentSnapshot.getLong("id");
        String name = documentSnapshot.getString("name");
        String muscleGroupText = documentSnapshot.getString("muscleGroup");
        String description = documentSnapshot.getString("description");

        MuscleGroup muscleGroup = MuscleGroup.valueOf(muscleGroupText);

        return new Exercise(
                id,
                name,
                muscleGroup,
                description
        );
    }

    // Convierte un ejercicio en un Map para guardarlo en Firebase
    private Map<String, Object> convertirEjercicioAMap(Exercise exercise) {
        Map<String, Object> datos = new HashMap<>();

        datos.put("id", exercise.getId());
        datos.put("name", exercise.getName());
        datos.put("muscleGroup", exercise.getMuscleGroup().name());
        datos.put("description", exercise.getDescription());

        return datos;
    }
}