# Generated by Django 3.2.7 on 2021-09-08 22:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ml', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='postresponse',
            name='packaging_time',
            field=models.FloatField(),
        ),
        migrations.AlterField(
            model_name='postresponse',
            name='rider_store',
            field=models.FloatField(),
        ),
        migrations.AlterField(
            model_name='postresponse',
            name='store_delivery',
            field=models.FloatField(),
        ),
    ]
