//! ${PROJECT_NAME} — Rust binary
//!
//! Quick start:
//!   nix develop
//!   cargo run

use std::path::PathBuf;

use tracing::{error, info};
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

#[derive(Debug)]
struct Config {
    port: u16,
}

impl Default for Config {
    fn default() -> Self {
        Self { port: 8080 }
    }
}

fn main() -> anyhow::Result<()> {
    // Initialize tracing/logging
    tracing_subscriber::registry()
        .with(tracing_subscriber::fmt::layer())
        .with(tracing_subscriber::EnvFilter::from_default_env())
        .init();

    let config = Config::default();

    info!(
        "Starting {} on port {}",
        env!("CARGO_PKG_NAME"),
        config.port
    );

    // Placeholder for actual application logic
    info!("Application ready. Press Ctrl+C to stop.");

    // Keep the application running
    tokio::signal::ctrl_c().await.map_err(|e| {
        error!("Failed to listen for Ctrl+C: {}", e);
        anyhow::anyhow!("Signal handler error")
    })?;

    info!("Shutting down gracefully.");
    Ok(())
}
