#!/bin/bash
# K3s Cluster Health Check Script

set -e

echo "🔍 K3s Cluster Health Check"
echo "============================"

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl not found"
    exit 1
fi

echo ""
echo "📋 Nodes:"
kubectl get nodes -o wide

echo ""
echo "📦 Pods (all namespaces):"
kubectl get pods -A --field-selector=status.phase!=Running

echo ""
echo "🔧 System Pods:"
kubectl get pods -n kube-system

echo ""
echo "💾 Node Resource Usage:"
kubectl top nodes 2>/dev/null || echo "   (metrics-server not available)"

echo ""
echo "📊 Cluster Info:"
kubectl cluster-info

echo ""
echo "✅ Health check complete"
