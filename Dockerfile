FROM python:3.7
LABEL maintainer="Tom Valk <tomvalk@lt-box.info>"
ENV PROJECT_ROOT /app

RUN apt-get -q update \
&& apt-get install -y build-essential libssl-dev libffi-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Create project root.
RUN mkdir -p $PROJECT_ROOT
WORKDIR $PROJECT_ROOT

# Install PyPlanet.
RUN pip install pyplanet --upgrade	

# Init project
RUN pyplanet init_project server
WORKDIR $PROJECT_ROOT/server
COPY base.py /app/server/settings/base.py

VOLUME /app/server/

ENTRYPOINT [ "./manage.py" ]
CMD [ "start", "--pool=default", "--settings=settings" ]