{{/*
Expand the name of the chart.
*/}}
{{- define "growthbook.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "growthbook.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "growthbook.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

# This helper will change when customers deploy a new image.
{{ define "growthbook.image" -}}
{{ printf "%s:%s" .Values.image.repository (.Values.image.tag | default .Chart.AppVersion) }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "growthbook.labels" -}}
helm.sh/chart: {{ include "growthbook.chart" . }}
{{ include "growthbook.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "growthbook.selectorLabels" -}}
app.kubernetes.io/name: {{ include "growthbook.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "growthbook.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "growthbook.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "growthbook.secretName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "growthbook.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the ingress URL
*/}}
{{- define "growthbook.ingressUrl" -}}
http{{ if .tls.secretName }}s{{ end }}://{{ .host }}
{{- end }}

{{/*
Default environment variables
*/}}
{{- define "growthbook.env" -}}
{{- $fullName := include "growthbook.fullname" . -}}
- name: APP_ORIGIN
  value: {{ .Values.growthbookSettings.appOrigin | quote }}
- name: API_HOST
  value: {{ .Values.growthbookSettings.apiHost | quote }}
- name: NODE_ENV
  value: {{ .Values.growthbookSettings.nodeEnv | quote }}
- name: UPLOAD_METHOD
  value: {{ .Values.growthbookSettings.uploadMethod | quote }}
{{- end }}
