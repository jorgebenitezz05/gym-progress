package com.jorge.gymprogress.service;

import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.jorge.gymprogress.model.Routine;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class RoutineService {

    private static final String ROUTINES_COLLECTION = "routines";
    private static final String COUNTERS_COLLECTION = "counters";
    private static final String ROUTINES_COUNTER_DOCUMENT = "routines";

    private final Firestore firestore;

    public RoutineService(Firestore firestore) {
        this.firestore = firestore;
    }

    // Obtiene todas las rutinas guardadas en Firebase
    public List<Routine> obtenerTodasLasRutinas() {
        try {
            QuerySnapshot querySnapshot = firestore.collection(ROUTINES_COLLECTION)
                    .orderBy("id")
                    .get()
                    .get();

            return querySnapshot.getDocuments()
                    .stream()
                    .map(this::convertirDocumentoARutina)
                    .toList();

        } catch (Exception e) {
            throw new RuntimeException("Error al obtener las rutinas desde Firebase", e);
        }
    }

    // Busca una rutina por su id en Firebase
    public Optional<Routine> obtenerRutinaPorId(Long id) {
        try {
            DocumentSnapshot documentSnapshot = firestore.collection(ROUTINES_COLLECTION)
                    .document(id.toString())
                    .get()
                    .get();

            if (!documentSnapshot.exists()) {
                return Optional.empty();
            }

            return Optional.of(convertirDocumentoARutina(documentSnapshot));

        } catch (Exception e) {
            throw new RuntimeException("Error al buscar la rutina en Firebase", e);
        }
    }

    // Guarda una nueva rutina en Firebase
    public Routine crearRutina(Routine routine) {
        try {
            Long nuevoId = obtenerSiguienteId();

            routine.setId(nuevoId);
            routine.setCreatedAt(LocalDateTime.now());

            Map<String, Object> datos = convertirRutinaAMap(routine);

            firestore.collection(ROUTINES_COLLECTION)
                    .document(nuevoId.toString())
                    .set(datos)
                    .get();

            return routine;

        } catch (Exception e) {
            throw new RuntimeException("Error al crear la rutina en Firebase", e);
        }
    }

    // Actualiza una rutina existente en Firebase
    public Optional<Routine> actualizarRutina(Long id, Routine rutinaActualizada) {
        try {
            DocumentReference documentReference = firestore.collection(ROUTINES_COLLECTION)
                    .document(id.toString());

            DocumentSnapshot documentSnapshot = documentReference.get().get();

            if (!documentSnapshot.exists()) {
                return Optional.empty();
            }

            Routine rutinaExistente = convertirDocumentoARutina(documentSnapshot);

            rutinaActualizada.setId(id);
            rutinaActualizada.setCreatedAt(rutinaExistente.getCreatedAt());

            Map<String, Object> datos = convertirRutinaAMap(rutinaActualizada);

            documentReference.set(datos).get();

            return Optional.of(rutinaActualizada);

        } catch (Exception e) {
            throw new RuntimeException("Error al actualizar la rutina en Firebase", e);
        }
    }

    // Elimina una rutina por id en Firebase
    public boolean eliminarRutina(Long id) {
        try {
            DocumentReference documentReference = firestore.collection(ROUTINES_COLLECTION)
                    .document(id.toString());

            DocumentSnapshot documentSnapshot = documentReference.get().get();

            if (!documentSnapshot.exists()) {
                return false;
            }

            documentReference.delete().get();

            return true;

        } catch (Exception e) {
            throw new RuntimeException("Error al eliminar la rutina en Firebase", e);
        }
    }

    // Genera ids numéricos para mantener compatibilidad con Flutter y los endpoints actuales
    private Long obtenerSiguienteId() {
        try {
            DocumentReference counterReference = firestore.collection(COUNTERS_COLLECTION)
                    .document(ROUTINES_COUNTER_DOCUMENT);

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
            throw new RuntimeException("Error al generar el siguiente id de rutina", e);
        }
    }

    // Convierte un documento de Firebase en un objeto Routine
    private Routine convertirDocumentoARutina(DocumentSnapshot documentSnapshot) {
        Long id = documentSnapshot.getLong("id");
        String name = documentSnapshot.getString("name");
        String description = documentSnapshot.getString("description");
        String createdAtText = documentSnapshot.getString("createdAt");

        LocalDateTime createdAt = createdAtText != null
                ? LocalDateTime.parse(createdAtText)
                : LocalDateTime.now();

        return new Routine(
                id,
                name,
                description,
                createdAt
        );
    }

    // Convierte una rutina en un Map para guardarla en Firebase
    private Map<String, Object> convertirRutinaAMap(Routine routine) {
        Map<String, Object> datos = new HashMap<>();

        datos.put("id", routine.getId());
        datos.put("name", routine.getName());
        datos.put("description", routine.getDescription());
        datos.put("createdAt", routine.getCreatedAt().toString());

        return datos;
    }
}