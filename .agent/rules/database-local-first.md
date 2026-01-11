# Database & Sync Strategy

- **Persistencia Local:** Toda la lógica de la aplicación debe interactuar primero con **Drift (SQLite)**.
- **Sincronización:**
  - Las tablas de Drift deben reflejar las tablas de Supabase.
  - Usa flags de sincronización (ej. `last_synced_at`, `is_dirty`) para gestionar el envío de datos a Supabase cuando el dispositivo esté online.
- **Migraciones:** No modifiques la base de datos local manualmente. Usa `supabase db diff` para generar migraciones SQL.
