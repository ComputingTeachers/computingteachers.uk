ARG BASE_IMAGE
FROM $BASE_IMAGE AS base
    COPY computingteachers.uk ./computingteachers.uk/
    RUN uv run --no-dev -m static_site_generator.app computingteachers.uk
