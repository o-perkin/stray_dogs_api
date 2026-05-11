# AI Agent Instructions

This is a Rails + React project.

Backend:
- Rails API code is in app/controllers/api/v1.
- Models are in app/models.
- Routes are in config/routes.rb.
- Database structure source of truth is db/schema.rb.
- Specs are in spec.

Frontend:
- React code is in material-kit-react-master/src.
- Do not rewrite the whole frontend structure.
- Make small, focused changes.

Rules:
- Before changing factories, check db/schema.rb and related model files.
- Do not delete existing specs unless the task explicitly requires it.
- Prefer adding specs over replacing old specs.
- Do not change unrelated endpoints or pages.
- Keep changes minimal and directly related to the task.
- If tests cannot be run, write the reason in PR_NOTES.md.
