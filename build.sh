#!/usr/bin/env bash
# exit on error
set -o errexit

# Update and install necessary system packages
apt-get update && apt-get install -y gcc libc-dev tzdata

# Upgrade pip and setuptools
pip install --upgrade pip setuptools

# Install dependencies
pip install -r requirements.txt

# Collect static files
python manage.py collectstatic --no-input

# Run migrations
python manage.py migrate

# Create superuser if the CREATE_SUPERUSER environment variable is set
if [[ $CREATE_SUPERUSER ]]; then
  python manage.py createsuperuser --no-input
fi
