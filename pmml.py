#!/usr/bin/env python3
import click
import sys
import os
import email
import email.parser
import smtplib
import json
from pathlib import Path


DEFAULT_CONFIG_FILE_PATH=Path.home() / ".pmmlrc"


def read_config_file(config_file_path):
    with open(config_file_path) as f:
        config = json.load(f)
    return config

def setup_smtp_session(smtp_server, smtp_port, smtp_user, smtp_pass):
    smtp_client = smtplib.SMTP(host=smtp_server, port=smtp_port)
    smtp_client.ehlo()
    smtp_client.starttls()
    smtp_client.login(smtp_user, smtp_pass)
    return smtp_client

@click.command()
@click.option("-f", "--config-file", default=DEFAULT_CONFIG_FILE_PATH)
@click.argument("mailing-list-address")
def cli(config_file, mailing_list_address):
    ignore_subjects = ("Undelivered Mail Returned to Sender",)
    input = sys.stdin
    config = read_config_file(config_file)[mailing_list_address]
    msg = email.parser.Parser().parse(input)

    if msg['Subject'] in ignore_subjects:
        print(f"Skipping mail processing because auf subject: {msg['Subject']}")
    else:
        smtp_client = setup_smtp_session(config['smtp_server'], config['smtp_port'],
                                     config['smtp_user'], config['smtp_pass'])
        smtp_client.sendmail(mailing_list_address, config['recipients'], msg.as_string())
        smtp_client.quit()

if __name__ == '__main__':
    cli()
