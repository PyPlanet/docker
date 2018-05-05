# PyPlanet 0.6.0

FROM python:3.6
MAINTAINER Tom Valk <tomvalk@lt-box.info>
ENV PROJECT_ROOT /app
# ENV PYTHONUNBUFFERED 1

RUN apt-get -q update \
&& apt-get install -y build-essential libssl-dev libffi-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Create project root.
RUN mkdir -p $PROJECT_ROOT
WORKDIR $PROJECT_ROOT

# Add manage.py
ADD manage.py $PROJECT_ROOT/manage.py

# Install PyPlanet.
RUN pip install pyplanet

# Define volumes.
VOLUME /app/settings /app/apps

ENTRYPOINT [ "./manage.py" ]
CMD [ "start", "--pool=default", "--settings=settings" ]
