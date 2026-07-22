package com.jorge.gymprogress.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

@Configuration
public class FirebaseConfig {

    @Bean
    public Firestore firestore() {
        try {

            GoogleCredentials credentials;

            // Si existe la variable de entorno FIREBASE_CONFIG (Render)
            String firebaseConfig = System.getenv("FIREBASE_CONFIG");

            if (firebaseConfig != null && !firebaseConfig.isBlank()) {

                InputStream serviceAccount = new ByteArrayInputStream(
                        firebaseConfig.getBytes(StandardCharsets.UTF_8));

                credentials = GoogleCredentials.fromStream(serviceAccount);

            } else {

                // Si estamos en local usamos el JSON de resources
                InputStream serviceAccount = getClass()
                        .getClassLoader()
                        .getResourceAsStream("firebase-service-account.json");

                if (serviceAccount == null) {
                    throw new RuntimeException(
                            "No se encontró firebase-service-account.json ni la variable FIREBASE_CONFIG");
                }

                credentials = GoogleCredentials.fromStream(serviceAccount);
            }

            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(credentials)
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
            }

            return FirestoreClient.getFirestore();

        } catch (Exception e) {
            throw new RuntimeException("Error al inicializar Firebase", e);
        }
    }
}