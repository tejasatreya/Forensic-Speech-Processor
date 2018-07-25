filename='00001.wav';
[x,fs]=audioread(filename);
hamming_window=hamming(256);
sample_size=size(x);
hz2mel = @(hz)(1127*log(1+hz/700));
mel2hz = @(mel)(700*exp(mel/1127)-700);
[mel_filters,f]=trifbank(13,256,[0 fs/2],fs,hz2mel,mel2hz);
mel_filters=transpose(mel_filters);
sample_count=sample_size/256;
sample_count=fix(sample_count);
for i=1:sample_count(1,1)
    for j=(1:256)
        hamming_out(j,i)=(x((i-1)*128+j,1)*hamming_window(j,1));
    end
end
for i=1:365
    fft_out(:,i)=fft(hamming_out(:,i));
end
energy_spectrum=abs(fft_out) .*abs(fft_out);
for i=1:365
    for j=1:13
        mel_out(j,i)=0;
        for k=1:256
            mel_out(j,i)=mel_out(j,i)+energy_spectrum(k,i)*mel_filters(k,j);
        end
    end
end
pre_dct=log10(mel_out);
for i=1:365
    dct_out(:,i)=dct(pre_dct(:,i));
end
