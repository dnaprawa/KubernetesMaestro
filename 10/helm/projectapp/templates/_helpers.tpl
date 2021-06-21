{{/*
Expand the name of the chart.
*/}}
{{- define "projectapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "projectapp.backend.name" -}}
{{- default .Chart.Name .Values.nameOverride "backend" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "projectapp.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride "-frontend"}}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name "frontend" | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $name "frontend" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "projectapp.backend.fullname" -}}
{{- if .Values.backend.fullnameOverride }}
{{- .Values.backend.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride "-backend"}}
{{- if contains $name .Release.Name }}
{{- printf "%s-%s" .Release.Name "backend" | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $name "backend" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "projectapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "projectapp.common.labels" -}}
helm.sh/chart: {{ include "projectapp.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{/*
Selector labels
*/}}
{{- define "projectapp.frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "projectapp.name" . }}-{{ "frontend" }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "projectapp.backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "projectapp.backend.name" . }}-{{ "backend" }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}



{{/*
Create config name
*/}}
{{- define "projectapp.configName" -}}
{{ include "projectapp.name" . }}-{{ "config" }}-{{ .Release.Name }}
{{- end }}