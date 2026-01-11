# CI/CD & Git Workflow

- **Control de Versiones:** Los commits deben seguir el estándar de [Conventional Commits](www.conventionalcommits.org).
- **GitHub Actions:** 
  - El pipeline debe ejecutarse en cada Pull Request.
  - Debe incluir: `melos run analyze`, `melos run test` y `supabase db verify`.
- **Despliegue:** El despliegue a producción es automático solo si el pipeline de GitHub Actions termina en verde.
