# NanoClaw Agent + Python/Beancount
# Extends the base agent image with Python, pipenv, and beancount dependencies.
# Dependencies are installed in a virtualenv at /opt/beancount and added to PATH.
#
# Rebuild when dependencies change:
#   ./container/images/beancount/build.sh

FROM nanoclaw-agent:latest

USER root

# Install Python 3 and build dependencies for native packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy Pipfile for dependency list
COPY Pipfile /tmp/beancount-deps/

# Create virtualenv and install deps via pip (extracted from Pipfile)
# Using pip directly avoids pipenv's Python version check (Pipfile wants 3.12, Debian has 3.11)
RUN python3 -m venv /opt/beancount && \
    /opt/beancount/bin/pip install --upgrade pip && \
    /opt/beancount/bin/pip install \
      beancount \
      fava \
      pynubank \
      python-decouple \
      oauth2client \
      gspread \
      pyopenssl \
      pytz \
      ofxparse \
      ipython

# Clean up build artifacts but keep python3-dev for potential future builds
RUN apt-get purge -y build-essential && \
    apt-get autoremove -y && \
    rm -rf /tmp/beancount-deps /root/.cache/pip

# Add virtualenv to PATH so beancount tools (bean-check, bean-query, fava) are available
ENV PATH="/opt/beancount/bin:$PATH"

# Verify beancount is available
RUN python3 -c "import beancount; print('beancount OK')" && \
    which bean-check && \
    which bean-query && \
    which fava

USER node
WORKDIR /workspace/group
ENTRYPOINT ["/app/entrypoint.sh"]
