package com.qst.entity;

public class FileChunk {
    private Integer fileChunkId;

    private Integer userId;

    private String fileName;

    private Integer chunks;

    private Integer chunk;

    private String filePath;

    private String fileMd5;

    private Integer chunkSize;

    private Integer fileStatus;

    private Integer percentage;

    public Integer getFileChunkId() {
        return fileChunkId;
    }

    public void setFileChunkId(Integer fileChunkId) {
        this.fileChunkId = fileChunkId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Integer getChunks() {
        return chunks;
    }

    public void setChunks(Integer chunks) {
        this.chunks = chunks;
    }

    public Integer getChunk() {
        return chunk;
    }

    public void setChunk(Integer chunk) {
        this.chunk = chunk;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileMd5() {
        return fileMd5;
    }

    public void setFileMd5(String fileMd5) {
        this.fileMd5 = fileMd5;
    }

    public Integer getChunkSize() {
        return chunkSize;
    }

    public void setChunkSize(Integer chunkSize) {
        this.chunkSize = chunkSize;
    }

    public Integer getFileStatus() {
        return fileStatus;
    }

    public void setFileStatus(Integer fileStatus) {
        this.fileStatus = fileStatus;
    }

    public Integer getPercentage() {
        return percentage;
    }

    public void setPercentage(Integer percentage) {
        this.percentage = percentage;
    }

	@Override
	public String toString() {
		return "FileChunk [fileChunkId=" + fileChunkId + ", userId=" + userId + ", fileName=" + fileName + ", chunks="
				+ chunks + ", chunk=" + chunk + ", filePath=" + filePath + ", fileMd5=" + fileMd5 + ", chunkSize="
				+ chunkSize + ", fileStatus=" + fileStatus + ", percentage=" + percentage + "]";
	}
    
}